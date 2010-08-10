module PostsHelper
  
  def tags_as_sentence(tags, links = true)
    raise "No tags" if tags.nil?
    sentence = []
    if links
      tags.each do |t|
        sentence << link_to(t.name, tags_path(t.name))
      end
    else
      sentence = tags
    end
    return sentence.to_sentence
  end
  
end