module NavbarHelper
  def navbar
    if (action_name == 'show' && controller_name == 'events') || action_name == 'home' || (action_name == 'show' && controller_name == 'profiles') || (action_name == 'new' && controller_name == 'sessions')
      render 'shared/navbar_home'
    elsif action_name == 'dashboard'
      render 'shared/navbar_dashboard'
    else
      render 'shared/navbar'
    end
  end
end
