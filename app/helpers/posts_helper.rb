module PostsHelper
  def list_categories(post)
    return post.categories.map(&:name).join(', ') if post.categories.any?
    'Uncategorized'
  end
end
