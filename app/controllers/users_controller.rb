class UsersController < ApplicationController
  before_action :require_login, except: [ :new, :create, :show, :activate ]
  skip_before_action :require_login, only: [ :new, :create, :activate ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

      if @user.save
        UserMailer.activation_needed_email(@user).deliver_now
        redirect_to root_path, notice: "確認メールを送信しました。メールアドレスを確認して下さい。"
      else
        render :new, status: :unprocessable_entity
      end
  end

  def auto_login(user)
    session[:user_id] = user.id
    @current_user = user
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

def activate
  user = User.load_from_activation_token(params[:id])
  if user
    user.activate!
    user.reload
    UserMailer.activation_success_email(user).deliver_now
    auto_login(user)
    flash[:notice] = "アカウント登録が完了しました！"
    redirect_to root_path
  else
    flash[:alert] = "アクティベーションリンクが無効です。"
    redirect_to root_path
  end
end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    # ログインしていない場合、ログイン画面にリダイレクト
    def not_authenticated
      flash[:warning] = "ログインが必要です"
      redirect_to login_path
    end
end
