module PostsHelper
  
  def tags_as_sentence(tags, links = true)
    raise "No tags" if tags.nil?
    sentence = []
    if links
      tags.each do |t|
        sentence << link_to(t.name.strip, tags_path(t.name.strip))
      end
    else
      sentence = tags
    end
    return sentence.to_sentence
  end
  
end
