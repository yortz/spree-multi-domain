class Store < ActiveRecord::Base
  has_many :products, :through => :products_stores
  has_many :taxonomies
  has_many :orders

  validates_presence_of :name, :code, :domains

  scope :default, where(:default => true)
  scope :by_domain, lambda { |domain| where("domains like ?", "%#{domain}%") }
  
  def self.current(domain = nil)
    current_store = domain ? Store.by_domain(domain).first : nil
    current_store || Store.default.first
  end
end
