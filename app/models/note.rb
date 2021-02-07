class Note < ApplicationRecord
  belongs_to :book, optional: true, inverse_of: :notes
  belongs_to :user, inverse_of: :notes

  validates :title, presence: true, length: {maximum: 255}
  validates :content, presence: true


  def export
    text = "#{self.title} <br> #{self.content}"
    md=Redcarpet::Markdown.new(Redcarpet::Render::HTML,tables: true)
    data = md.render(text)
    # File.open("note_#{title}.html", 'w') { |file| file.write md }
    return data
  end


end
