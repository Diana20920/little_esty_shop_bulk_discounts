class FixQuatityTypo < ActiveRecord::Migration[5.2]
  def change
    rename_column :bulk_discounts, :quatity, :quantity
  end
end
