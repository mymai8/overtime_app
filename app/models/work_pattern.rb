class WorkPattern < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '早出A' },
    { id: 3, name: '早出B' },
    { id: 4, name: '早出C' },
    { id: 5, name: '早出D' },
    { id: 6, name: '早出E' },
    { id: 7, name: '早出F' },
    { id: 8, name: '通常A' },
    { id: 9, name: '通常B' },
    { id: 10, name: '通常C' },
    { id: 11, name: '遅出A' },
    { id: 12, name: '遅出B' },
    { id: 13, name: '遅出C' },
    { id: 14, name: '遅出D' },
    { id: 15, name: '遅出E' },
    { id: 16, name: '遅出F' },
    { id: 17, name: '遅出G' },
  ]

  include ActiveHash::Associations
  has_many :users
  has_many :overtime_requests
end
