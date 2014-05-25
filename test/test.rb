require_relative '../lib/video-preview'
image = VideoPreview.get_preview File.join(__dir__, 'trailer.mp4')
puts image
