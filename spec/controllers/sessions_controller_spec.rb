require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "redirects to root if user is logged in" do
      user = create(:user)
      session[:user_id] = user.id

      get :new
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #create" do
    let!(:user) { create(:user, email: "test@example.com", password: "password123") }

    it "logs in with valid credentials" do
      post :create, params: { email: "test@example.com", password: "password123" }

      expect(response).to redirect_to(root_path)
      expect(session[:user_id]).to eq(user.id)
    end

    it "renders new with error for invalid credentials" do
      post :create, params: { email: "test@example.com", password: "wrong" }

      expect(response).to render_template(:new)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(flash[:alert]).to eq("Invalid email or password")
      expect(session[:user_id]).to be_nil
    end
  end

  describe "DELETE #destroy" do
    it "logs out the user" do
      user = create(:user)
      session[:user_id] = user.id

      delete :destroy

      expect(response).to redirect_to(login_path)
      expect(session[:user_id]).to be_nil
    end
  end
end
