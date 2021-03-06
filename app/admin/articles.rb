ActiveAdmin.register Article do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :author_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :author_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  filter :author
  filter :title
  filter :categories
  filter :created_at
  filter :updated_at
  
  index do
    selectable_column
    column :id
    column :title
    column :description
    actions
  end
end
