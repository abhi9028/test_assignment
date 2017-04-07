module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      loginuser = FactoryGirl.create(:user)
      sign_in loginuser
    end
  end
end
