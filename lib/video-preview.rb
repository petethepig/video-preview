require 'json'
require 'tmpdir'
require 'RMagick'

module VideoPreview

  VERSION = "0.0.1"

  def self.rank image
    total_red = 0
    total_blue = 0
    total_green = 0

    average_red = 0
    average_blue = 0
    average_green = 0

    distance_red = 0
    distance_blue = 0
    distance_green = 0

    pixel_count = image.rows * image.columns
    hist = image.color_histogram

    hist.each do |pixel, count|
      total_red += pixel.red*count
      total_blue += pixel.blue*count
      total_green += pixel.green*count
    end

    average_red = total_red / pixel_count
    average_blue = total_blue / pixel_count
    average_green = total_green / pixel_count

    hist.each do |pixel, count|
      distance_red += (average_red - pixel.red).abs
      distance_blue += (average_blue - pixel.blue).abs
      distance_green += (average_green - pixel.green).abs
    end

    return distance_green + distance_blue + distance_red
  end

  def self.get_preview filepath, opts = {}
    opts[:N] ||= 20
    json = JSON.parse `ffprobe -print_format json -show_streams #{filepath} 2> /dev/null`
    if json['streams']
      stream = json['streams'].select {|stream| stream['codec_type'] == 'video'}.first
      if stream && stream['duration']
        Dir.mktmpdir do |dir|
          `ffmpeg -i #{filepath} -f image2 -vf fps=fps=1/#{stream['duration'].to_f / opts[:N]} #{dir}/%010d.png 2> /dev/null`
          return Dir.glob(File.join(dir, "*.png")).map {|x| Magick::ImageList.new(x)[0] }.max_by {|x| rank x }
        end
      end
    end
  end
end
