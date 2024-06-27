class Role < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '部長' },
    { id: 3, name: '課長' },
    { id: 4, name: '次長' },
    { id: 5, name: '社員' },
  ]

  include ActiveHash::Associations
  has_many :users
  
end