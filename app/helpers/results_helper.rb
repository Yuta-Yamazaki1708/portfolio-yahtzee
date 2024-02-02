module ResultsHelper
  def sort_link(column, title)
    direction = (column == params[:sort_column] && params[:sort_order] == 'asc') ? 'desc' : 'asc'
    arrow = (direction == 'asc') ? "^" : "⌄"
    link_to (title + arrow), profile_path(sort_column: column, sort_order: direction)
  end
end
