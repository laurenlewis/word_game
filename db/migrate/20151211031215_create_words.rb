class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :verbs_animate_transitive_3rdsing
      t.string :noun_concrete_count_that_a_singular
      t.string :noun_concrete_count_that_the_singular
      t.string :noun_concrete_count_that_plural
      t.string :noun_concrete_count_that_the_plural
      t.string :noun_concrete_count_who_a_singular
      t.string :noun_concrete_count_who_the_singular
      t.string :noun_concrete_count_who_plural
      t.string :noun_concrete_count_who_the_plural
      t.string :noun_abstract
      t.string :adjective_animate
      t.string :adjective_inanimate

      t.timestamps null: false
    end
  end
end
