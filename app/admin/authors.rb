ActiveAdmin.register Author do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :failed_attempts, :locked_at, :unlock_token
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :failed_attempts, :locked_at, :unlock_token]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  action_item :unlock,only: :edit do
    link_to 'Unlock User', unlock_admin_author_path(author),method: :put if author.access_locked?
  end
  action_item :lock,only: :edit do
    link_to 'Lock User', lock_admin_author_path(author),method: :put if not author.access_locked?
  end

  member_action :lock,method: :put do
    author = Author.find(params[:id])
    author.lock_access!
    # author.locked_at = nil
    # author.failed_attempts = 0 
    # author.unlock_token = nil  
    # author.save(:validate => false)
    redirect_to admin_author_path(author)
  end

  member_action :unlock,method: :put do
    author = Author.find(params[:id])
    author.unlock_access!
    # author.locked_at = nil
    # author.failed_attempts = 0 
    # author.unlock_token = nil  
    # author.save(:validate => false)
    redirect_to admin_author_path(author)
  end

  filter :articles
  filter :email
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :id
    column :email
    column :created_at
    column :updated_at
    column :locked_at
    actions
  end
end
