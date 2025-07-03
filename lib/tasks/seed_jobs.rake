# lib/tasks/seed_jobs.rake
namespace :jobs do
  desc "Seed the database with sample job postings"
  task seed: :environment do
    puts "Creating sample job postings..."

    job_titles = [
      "Senior Behavioral Scientist",
      "Nudge Unit Researcher",
      "UX Researcher",
      "Product Research Manager",
      "Behavioral Economics Analyst",
      "Decision Science Lead",
      "Customer Insights Manager",
      "Behavioral Data Scientist",
      "Research Scientist - Psychology",
      "Applied Behavioral Researcher",
      "Choice Architecture Specialist",
      "Consumer Psychology Manager",
      "Behavioral Design Researcher",
      "Experimental Design Lead",
      "Social Psychology Researcher",
      "Behavioral Product Manager",
      "Market Research Analyst",
      "Human Factors Researcher",
      "Policy Research Associate",
      "Behavioral Strategy Consultant"
    ]

    countries = [
      "Remote", "Mixed", "United Kingdom", "United States", "Germany",
      "Netherlands", "Canada", "Australia", "France", "Sweden",
      "Denmark", "Switzerland", "Singapore", "Japan", "Israel",
      "Belgium", "Austria", "Norway", "Finland", "Ireland"
    ]

    visa_requirements = [ "required", "not_required", "unknown" ]

    companies = [
      "Behavioral Insights Team", "Google", "Microsoft", "Amazon", "Meta",
      "Spotify", "Airbnb", "Uber", "Netflix", "Salesforce",
      "McKinsey & Company", "BCG", "Bain & Company", "Deloitte",
      "University of Chicago", "Stanford University", "MIT",
      "ideas42", "BVA Nudge Unit", "The Behavioural Architects",
      "Common Cents Lab", "Center for Advanced Hindsight"
    ]

    descriptions = [
      "We're looking for a talented behavioral scientist to join our team and help design interventions that improve user engagement and decision-making. You'll work on exciting projects across healthcare, finance, and consumer products.",

      "Join our world-class research team to conduct experiments and analyze user behavior. We're building products used by millions of people and need someone who can translate behavioral insights into product improvements.",

      "Exciting opportunity to apply behavioral economics principles to real-world challenges. You'll design and run randomized controlled trials, analyze large datasets, and work with cross-functional teams.",

      "We're seeking a researcher with experience in choice architecture and nudging to help us improve customer outcomes. This role involves both qualitative and quantitative research methods.",

      "Lead behavioral research initiatives for our growing fintech company. You'll design experiments, analyze user behavior, and help build features that help people make better financial decisions.",

      "Research position focusing on social psychology and decision science. You'll work on projects related to health behavior change, sustainability, and digital wellness.",

      "Hybrid role combining behavioral research with product strategy. Perfect for someone who wants to see their research directly impact millions of users.",

      "Academic-industry collaboration opportunity. Conduct cutting-edge research while working with practitioners to implement behavioral interventions at scale.",

      "Join our behavioral science consultancy and work with Fortune 500 companies to improve employee engagement, customer experience, and business outcomes.",

      "Early-career opportunity perfect for recent PhD graduates. You'll receive mentorship while working on high-impact projects in healthcare and public policy."
    ]

    application_urls = [
      "https://jobs.lever.co/company/123",
      "https://careers.google.com/jobs/results/456",
      "https://www.linkedin.com/jobs/view/789",
      "https://boards.greenhouse.io/company/jobs/012",
      "https://company.workday.com/careers/job/345",
      "https://apply.workable.com/company/j/678",
      "jobs@company.com",
      "https://company.bamboohr.com/jobs/view.php?id=901",
      "https://recruiting.ultipro.com/company/234",
      "https://career-page.com/behavioral-scientist",
      "https://university.edu/jobs/research-positions",
      "apply@behavioralteam.org",
      "linkedin.com/jobs/view/987654321",
      "glassdoor.com/job-listing/behavioral-researcher",
      "indeed.com/viewjob?jk=abc123def456"
    ]

    50.times do |i|
      job_posting = JobPosting.create!(
        title: job_titles.sample,
        description: descriptions.sample +
                    "\n\nRequirements:\n• PhD or Master's in Psychology, Economics, or related field\n• 2+ years of experience in applied research\n• Strong statistical analysis skills\n• Experience with A/B testing\n\nWe offer competitive salary, excellent benefits, and the opportunity to make a real impact.",
        country: countries.sample,
        visa_requirement: visa_requirements.sample,
        application_url: application_urls.sample,
        approved: [ true, true, true, false ].sample, # 75% approved, 25% pending
        date_posted: rand(30.days).seconds.ago
      )

      print "." if i % 5 == 0
    end

    approved_count = JobPosting.approved.count
    pending_count = JobPosting.pending.count

    puts "\n\nCreated 50 job postings:"
    puts "- #{approved_count} approved (visible on public site)"
    puts "- #{pending_count} pending approval"
    puts "\nCountries represented: #{JobPosting.distinct.pluck(:country).compact.sort.join(', ')}"
    puts "Visa requirements: #{JobPosting.distinct.pluck(:visa_requirement).compact.join(', ')}"
    puts "\nRun 'rails jobs:clear' to remove all job postings"
  end

  desc "Clear all job postings"
  task clear: :environment do
    count = JobPosting.count
    JobPosting.destroy_all
    puts "Deleted #{count} job postings"
  end
end
