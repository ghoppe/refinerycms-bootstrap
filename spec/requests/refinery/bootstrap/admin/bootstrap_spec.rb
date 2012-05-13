# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Bootstrap" do
    describe "Admin" do
      describe "bootstrap" do
        login_refinery_user

        describe "bootstrap list" do
          before(:each) do
            FactoryGirl.create(:bootstrap, :title => "UniqueTitleOne")
            FactoryGirl.create(:bootstrap, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.bootstrap_admin_bootstrap_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.bootstrap_admin_bootstrap_path

            click_link "Add New Bootstrap"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Bootstrap::Bootstrap.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::Bootstrap::Bootstrap.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:bootstrap, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.bootstrap_admin_bootstrap_path

              click_link "Add New Bootstrap"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Bootstrap::Bootstrap.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:bootstrap, :title => "A title") }

          it "should succeed" do
            visit refinery.bootstrap_admin_bootstrap_path

            within ".actions" do
              click_link "Edit this bootstrap"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:bootstrap, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.bootstrap_admin_bootstrap_path

            click_link "Remove this bootstrap forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Bootstrap::Bootstrap.count.should == 0
          end
        end

      end
    end
  end
end
