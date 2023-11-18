class UserController < ApplicationController
    before_action :authenticate_admin_user!

    def index
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true)
        @users = User.all_users
    end

    def show
        @user = User.find_user(params[:id])
    end

    def new
        @user = User.new_user
    end

    def create
        @user = User.new_user
        if @user.create_user(user_params)
            redirect_to users_path, notice: 'ユーザーの作成に成功しました'
        else
            render :new
        end
    end

    def edit
        @user = User.find_user(params[:id])
    end

    def update
        @user = User.find_user(params[:id])
        @user.destroy_user
        redirect_to users_path, notice: 'ユーザの削除に成功しました'
    end

    private

    def user_params
        params.require(:user).permit(:last_name, :first_name, :email, :password :password_confirmation)
    end
end
