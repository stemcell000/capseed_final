# Preview all emails at http://localhost:3000/rails/mailers/seed_mailer
class SeedMailerPreview < ActionMailer::Preview
  def seed_mailer_preview
    SeedMailer.seed_email(User.first)
  end
end