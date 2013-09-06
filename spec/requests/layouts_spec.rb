require 'spec_helper'

# simple tests for basic layout elements
describe 'layout requests', :js => true do
  subject { page }

  describe ( 'get /' ) {
    before { visit refinery::root_path }

    it ( 'should have header links' ) {
      should have_css 'header nav'

      should have_css "header a[href*='#{refinery::marketable_page_path('about')}']"
      should have_css "header a[href*='#{map_path}']"
      should have_css "header a[href*='#{countries_path}']"
      should have_css "header a[href*='#{refinery::blog_root_path}']"
    }

    it ( 'should have footer links' ) {
      should have_css( 'footer nav' );

      should have_css "footer a[href*='#{refinery::marketable_page_path('about')}']"
      should have_css "footer a[href*='#{refinery::blog_root_path}']"
    }

    it {
      should have_css '.data-nav-countries'
      should have_css '.countries-nav-list'
      should_not have_css '.countries-nav-list.expanded'
    }

    describe ( 'click countries' ) {
      it {
        click_link 'countries'
        should have_css '.countries-nav-list.expanded'
      }
    }

    describe ( 'click countries twice' ) {
      it ( 'should hide country list' ) {
        click_link 'countries'
        click_link 'countries'
        should_not have_css '.countries-nav-list.expanded'
      }
    }

    it {
      should have_css '.data-nav-categories'
      should have_css '.category-selector'
      should_not have_css '.category-selector.expanded'
    }

    describe ( 'click categories' ) {
      it {
        click_link 'categories'
        should have_css '.category-selector.expanded'
      }
    }

    describe ( 'click categories twice' ) {
      it ( 'should hide country list' ) {
        click_link 'categories'
        click_link 'categories'
        should_not have_css '.category-selector.expanded'
      }
    }

    context ( 'with countries expended, click categories' ) {
      it ( 'should close countries' ) {
        click_link 'countries'
        click_link 'categories'
        should_not have_css '.countries-nav-list.expanded'
        should have_css '.category-selector.expanded'
      }
    }
  }
end