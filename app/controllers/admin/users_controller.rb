class Admin::UsersController < ApplicationController
  before_filter :authenticate_admin
end
