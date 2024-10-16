Rails.application.routes.draw do
  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # ユーザー用
  scope module: :public do
    # homes
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    # users
    get '/users/mypage' => 'users#mypage', as: 'mypage'
    get '/users/profile/edit' => 'users#edit', as: 'edit_user'
    patch '/users/profile' => 'users#update', as: 'update_user'
    get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    resources :users, only: [:show, :destroy] do
      resource :relationships, only: [:create, :destroy]
    end
    # searches
    get '/user_search_result' => 'searches#search', as: 'search'
    # relationships
    get '/followings' => 'relationships#followings', as: 'followings'
    get '/followers' => 'relationships#followers', as: 'followers'
    # rooms
    resources :rooms, only: [:show, :create]
    # messages
    resources :messages, only: [:create]
    # posts
    get '/posts/timeline' => 'posts#timeline', as: 'timeline'
    resources :posts, only: [:new, :index, :show, :create, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :book_marks, only: [:create, :destroy]
    end
    # book_marks
    resources :book_marks, only: [:index]
    # camp_layouts
    resources :camp_layouts, only: [:index]
    # camp_meals
    resources :camp_meals, only: [:index]
    # campsites
    resources :campsites, only: [:index]
    # reports
    resources :reports, only: [:new, :create]
    # inquiries
    resources :inquiries, only: [:new, :create]
  end

  # 管理者用
  namespace :admin do
    # homes
    get '/' => 'homes#top', as: 'top'
    # users
    resources :users, only: [:index, :show]
    # searches
    get '/user_search_result' => 'searches#search', as: 'search'
    # reports
    resources :reports, only: [:index, :show]
    # inquiries
    resources :inquiries, only: [:index, :show]
  end
end