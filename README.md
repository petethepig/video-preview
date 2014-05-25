# Video Preview

This little library allows you to generate video previews in a wise manner. Specifically, it picks N frames from a video and then ranks them by the contrast ratio of an image.

To install it, simply run `gem install video-preview`. The library has two main dependencies: `ffmpeg` and `imagemagick`. Make sure you have them as well.

Here's an example on how to use it:

```ruby
require 'video-preview'
VideoPreview.get_preview 'trailer.mp4'
# => #<Magick::Image:0x007fd5738869b8>
```
