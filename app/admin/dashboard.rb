ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    columns do
      column do
        # cheap tactic to get centering :shrugs:
        h2 ""
      end
      column do
        h2 do
          text_node image_tag "https://www.quizdb.org/quizdb.png", size: "64x56"
          text_node "Welcome to QuizDB: Admin!"
        end
      end
      column do;end
    end

    div do
      columns do
        column do
          h2 ""
        end
        column do
          h4 "If this is your first time here, try viewing the various datasets from the links in the navbar up top."
          h5 "If you're an admin, check out the tables below for a quick summary of the latest activity in QuizDB."
        end
        column do
          ""
        end
      end
    end

    TABLE_LIMIT = 15

    columns do
      column span: 2 do
        panel "Most recent errors" do
          table_for Error.all.order(updated_at: :desc).limit(TABLE_LIMIT) do
            column(:id) {|q| link_to q.id, admin_error_path(q)}
            column :error_type
            column(:description) {|q| q.description.truncate(50)}
            column(:resolved)
            column(:question) {|q| q.errorable_type == "Tossup" ?
              link_to("Tossup #{q.id}", admin_tossup_path(q.errorable)) :
              link_to("Bonus #{q.id}", admin_bonus_path(q.errorable))}
            column :updated_at
          end
        end
      end

      column do
        panel "Tossups with most errors" do
          table_for Tossup.all.reorder("").order(errors_count: :desc).limit(TABLE_LIMIT) do
            column(:id) {|q| link_to(q.id, admin_tossup_path(q))}
            column :errors_count
          end
        end
      end

      column do
        panel "Bonuses with most errors" do
          table_for Bonus.all.reorder("").order(errors_count: :desc).limit(TABLE_LIMIT) do
            column(:id) {|q| link_to(q.id, admin_bonus_path(q))}
            column :errors_count
          end
        end
      end

    end

    columns do
      column do
        panel "Most recent tossup changes" do
          table_for Tossup.all.reorder("").order(updated_at: :desc).limit(TABLE_LIMIT) do
            column(:id) {|q| link_to(q.id, admin_tossup_path(q))}
            column(:text) {|q| q.formatted_text.truncate(50).html_safe}
            column(:answer) {|q| q.formatted_answer.truncate(50).html_safe}
            column :tournament
            column :updated_at
          end
        end
      end
      column do
        panel "Most recent bonus changes" do
          table_for Bonus.all.reorder("").order(updated_at: :desc).limit(TABLE_LIMIT) do
            column(:id) {|q| link_to(q.id, admin_bonus_path(q))}
            column(:content) {|q| q.html_content.truncate(100).html_safe}
            column :tournament
            column :updated_at
          end
        end
      end
    end

  end
end
