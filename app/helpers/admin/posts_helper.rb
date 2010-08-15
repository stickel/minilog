module Admin::PostsHelper
  def display_image_code(image)
    sizes = ['thumb', 'small', 'large', 'original']
    basename = image['upload_file_name'].split('.')
    code = '<span class="help clear">'
    sizes.each do |size|
  		code += 'Display image size <b>' + size + '</b>:<br />' + "\n"
  		code += '{{ image ' + basename[0] + '_' + size + '.' + basename[1] + ' }}<br />' + "\n"
      # code += '{{ image ' + basename[0] + '_' + size + '.' + basename[1] + ' alt text, class names, id}}<br />' + "\n"
    end
		code += '</span>'
		return code
  end
end
