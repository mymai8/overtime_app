Rails.application.routes.draw do
  devise_for :users

  resources :deputy_directors, only: [:index]

  root to: 'attendances#new'
  resources :attendances, only: [:new, :create, :edit, :update, :index]

  resources :overtime_requests, only: [:new, :create, :show, :index] do
    member do
      get :export
    end
  end

  resources :actual_overtime_requests, only: [:new, :create, :show, :index] do
    member do
      get :export
    end
  end
end
