require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:user)).to be_a_new(User)
    end

    it "redirects to root if user is logged in" do
      user = create(:user)
      session[:user_id] = user.id

      get :new
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #create" do
    before do
      allow_any_instance_of(GeoLocation).to receive(:coordinates).and_return({
        latitude: 40.7128,
        longitude: -74.0060
      })
    end

    let(:valid_params) do
      {
        email: "test@example.com",
        password: "password123",
        street: "123 Main St",
        city: "Example City",
        zip: "12345"
      }
    end

    it "creates a new user with valid params" do
      expect {
        post :create, params: valid_params
      }.to change(User, :count).by(1)

      expect(response).to redirect_to(root_path)
      expect(session[:user_id]).to eq(User.last.id)
    end

    it "doesn't create a user with invalid params" do
      expect {
        post :create, params: valid_params.merge(email: "")
      }.not_to change(User, :count)

      expect(response).to render_template(:new)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET #show" do
    let(:user) { create(:user) }

    it "renders the show template for authenticated user" do
      session[:user_id] = user.id

      get :show
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
    end

    it "redirects to login if user is not authenticated" do
      get :show
      expect(response).to redirect_to(login_path)
    end
  end
end
