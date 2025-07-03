Rails.application.routes.draw do
  root "job_postings#index"
  resources :job_postings, only: [ :index, :show ]
  resources :job_submissions, only: [ :new, :create ]

  get "about", to: "pages#about"

  namespace :admin do
    resources :job_postings do
      member do
        patch :approve
      end
    end
  end
end
