Rails.application.routes.draw do
  get 'welcome/index' => 'welcome#index'
  
  root 'welcome/index'
  

  
end
