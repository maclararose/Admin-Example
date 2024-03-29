ActiveAdmin.register Post do
  permit_params :title, :body, :published_at, :user_id

  scope :all
  scope :published
  scope :unpublished

  form do |f|
    inputs "Details" do
      input :user 
      input :title 
      input :body
    end
    actions
  end

  action_item :publish, only: :show do
    link_to "Publish", publish_admin_post_path(post), method: :put if !post.published_at?
  end

  action_item :unpublish, only: :show do
    link_to "Unpublish", unpublish_admin_post_path(post), method: :put if post.published_at?
  end

  member_action :publish, method: :put do
    post = Post.find(params[:id])
    post.update(published_at: Time.zone.now)
    redirect_to admin_post_path(post)
  end

  member_action :unpublish, method: :put do
    post = Post.find(params[:id])
    post.update(published_at: nil)
    redirect_to admin_post_path(post)
  end
end
