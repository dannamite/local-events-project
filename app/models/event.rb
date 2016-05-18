require_relative "../../lib/blacklist"
class Event < ActiveRecord::Base
  include ActiveModel::Validations

  class ProfanityValidator < ActiveModel::Validator
    attr_reader :word_list

    def initialize(options)
      @word_list = options.fetch :word_list, []
    end

    def validate(event)
      profane = word_list.include?(event.name)
      event.errors.add(:name, 'That name is not accepted. Please enter a new name.') if profane
    end
  end

  def self.word_list
    @word_list || YAML::load(File.open("#{::Rails.root.to_s}/config/blacklist.yml"))
  end

  def self.word_list=(word_list)
    @word_list = word_list
  end

  has_many :links
  before_create :validate_name

  validates :name, presence: true
  validates_uniqueness_of :name
  validates_with ProfanityValidator, word_list: word_list
  mount_uploader :image, ImageUploader



end
