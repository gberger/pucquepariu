shared_context "when logged out" do
  before { @user = nil }
  before { session[:user_id] = nil }
end

shared_context "when logged in as a basic user" do
  before { @user = create(:user) }
  before { session[:user_id] = @user.id }
end

shared_context "when logged in as a teacher" do
  before { @user = create(:teacher) }
  before { session[:user_id] = @user.id }
end

shared_context "when logged in as an admin" do
  before { @user = create(:admin) }
  before { session[:user_id] = @user.id }
end


shared_context "who doesn't teach the course" do
  before { @course = create(:course) }
end

shared_context "who teaches the course" do
  before { @course = create(:course, teacher: @user) }
end