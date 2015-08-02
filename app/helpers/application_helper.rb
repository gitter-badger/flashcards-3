module ApplicationHelper
  def glyph_icon(name)
    raw("<span class='glyphicon glyphicon-#{name}' aria-hidden='true'></span>")
  end
end
