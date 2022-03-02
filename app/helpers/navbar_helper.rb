module NavbarHelper
  def navbar
    if action_name == 'home'
      render 'shared/navbar_home'
    elsif action_name == 'dashboard'
      render 'shared/navbar_dashboard'
    else
      render 'shared/navbar'
    end
  end
end
