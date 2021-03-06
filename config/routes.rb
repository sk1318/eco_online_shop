Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   root to: "public/homes#top"
   get "about"=> "public/homes#about",as: "about"
   get "admin"=>"admin/homes#top",as: "admin_top"
   
  namespace :admin do
   resources :items
   resources :customers
   resources :genres,only:[:index,:create,:edit,:update]
   resources :orders,only:[:index,:show,:update]
   resources :order_details,only:[:update]
  end
  
   devise_for :admin, :controllers => {
    :registrations => 'admin/registrations',
    :sessions => 'admin/sessions'   
   } 
  
  
  scope module: :public do
    resources :card, only: [:new, :show] do
      collection do
        post 'show', to: 'card#show'
        post 'pay', to: 'card#pay'
        post 'delete', to: 'card#delete'
      end
    end
    get 'products/index'=>"products#index"
    post 'products/pay'=>"products#pay"
    
    get "customers/mypage"=> "customers#show",as: "mypage"
    get "customers/edit"=>"customers#edit",as: "edit_customer"
    patch "customers"=>"customers#update"
    patch "costomers/withdraw"=>"customers#withdraw",as: "withdraw"    
    get "customers/cancellation"=>"customers#cancellation",as: "cancellation"
    devise_for :customers
    resources :items,only: [:index,:show]
    delete "cart_items/destroy_all"=>"cart_items#destroy_all",as: "destroy_all"
    resources :cart_items,only: [:create,:index,:update,:destroy]
    post "orders/confirm"=>"orders#confirm",as: "confirm"
    get "orders/confirm"=>"orders#new"
    get "orders/done"=> "orders#done",as: "done"
    resources :orders,only:[:index,:show,:create,:new]
    resources :addresses,only:[:index,:create,:edit,:update,:destroy]
    resources :genres,only:[:show]
  end
end