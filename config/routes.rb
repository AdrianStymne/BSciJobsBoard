Rails.application.routes.draw do
  root "job_postings#index"
  get "about", to: "pages#about"
  resources :job_postings, only: [ :index, :show ]
  resources :job_submissions, only: [ :new, :create ]
  namespace :admin do
  resources :job_postings
  resources :job_submissions, only: [ :index, :show, :destroy ] do
    member do
      patch :approve
    end
  end
end
end
