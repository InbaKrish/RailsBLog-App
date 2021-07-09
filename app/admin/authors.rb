ActiveAdmin.register Author do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :failed_attempts, :locked_at, :unlock_token,:password, :password_confirmation
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :failed_attempts, :locked_at, :unlock_token]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  scope :all, :default => true
  scope :banned_authors do |authors|
    authors.where("locked_at is not null")
  end

  action_item :lock,only: :edit do
    if author.access_locked?
      link_to 'Unlock User', unlock_admin_author_path(author),method: :put 
    else
      link_to 'Lock User', lock_admin_author_path(author),method: :put
    end
  end

  action_item :import_action,:only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv, only: :index do
    # Services::Conversion.new.from_csv(params[:file])
    # redirect_to admin_author_path(author)
  end
  collection_action :import,method: :post do
    if params[:file].to_s.length > 0
      Services::Conversion.new.from_csv(params[:file])
      flash[:notice] = "CSV imported successfully!"
      redirect_to :action => :index
    else
      flash[:notice] = "File (CSV) is empty"
      redirect_to upload_csv_admin_authors_path
    end
  end


  member_action :lock,method: :put do
    author = Author.find(params[:id])
    author.lock_access!
    redirect_to edit_admin_author_path(author)
  end

  member_action :unlock,method: :put do
    author = Author.find(params[:id])
    author.unlock_access!
    redirect_to edit_admin_author_path(author)
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
    column :locked_at if params[:scope] == "banned_authors"
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end