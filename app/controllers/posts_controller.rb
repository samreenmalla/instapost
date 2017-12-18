
class PostsController < ActionController::Base
  def index

  end


def new
  @post = Post.new
end

end