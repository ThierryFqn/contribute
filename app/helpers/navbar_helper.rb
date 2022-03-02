module NavbarHelper
  def navbar
    if action_name == 'home'
      render 'shared/navbar_home'
    else
      render 'shared/navbar'
    end
  end
end
