class Admin::UserController < ApplicationController

  def index
    @users = Admin::User.includes(:roles, :company).joins(:roles, :company).all
  end

  def show
    @user = Admin::User.find(params[:id])
  end

  def new
    @user = Admin::User.new
  end

  def edit
    @user = Admin::User.find(params[:id])
  end

  def create
    @user = Admin::User.new(params[:company_ownership].permit!)

    respond_to do |format|
      if @user.save
        message = t('success_create', scope: [:pico, :notices, :success], model: User.model_name.human.mb_chars.downcase)
        format.html { redirect_to [:admin, :index], notice: message }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @user = Admin::User.find(params[:id])
    respond_to do |format|
      if @user.update(params[:company_ownership].permit!)
        message = t('success_update', scope: [:pico, :notices, :success], model: User.model_name.human.mb_chars.downcase)
        format.html { redirect_to [:admin, :index], notice: message }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user = Admin::User.find(params[:id])
    @user.destroy
    respond_to do |format|
      message = t('success_destroy', scope: [:pico, :notices, :success], model: User.model_name.human.mb_chars.downcase)
      format.html { redirect_to [:admin, :index], notice: message }
    end
  end

end
