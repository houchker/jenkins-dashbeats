require 'date'


job_names = ['JobA',
            'JobB',
            'JobC',
            'Maven-master',
            'Git-master',
            'Active-Directory',
            'HAJP']

failed_jobs = [
            'JobB',
            'JobC',
            'Git-master',
            'HAJP']

failure_causes = [
            'jenkinsfailure',
            'Transformation error',
            'Compilation error',
            'NullPointerException',
            'failed to push some refs',
            'Network connection error']

failure_counts = Hash.new({ value: 0 })

status = ['SUCCESS',
          'FAILED',
          'UNSTABLE']

failed_status = [
          'FAILED',
          'UNSTABLE']

results = ['total: 8	Success: 0	Failures: 8	Unstables: 0	Rate of failure: 0%',
           'total: 10	Success: 2	Failures: 8	Unstables: 0	Rate of failure: 20%',
           'total: 11	Success: 3	Failures: 8	Unstables: 0	Rate of failure: 27%',
           'total: 7	Success: 4	Failures: 3	Unstables: 0	Rate of failure: 57%',
           'total: 7	Success: 5	Failures: 2	Unstables: 0	Rate of failure: 76%',
           'total: 9	Success: 6	Failures: 3	Unstables: 0	Rate of failure: 66%']


builds_results = Hash.new({ value: 0 })
latest_failed_builds = Hash.new({ value: 0 })
top_failed_jobs = Hash.new({ value: 0 })

SCHEDULER.every '2s' do
  date = DateTime.now
  random_job = job_names.sample
  random_status = status.sample
  random_failed_jobs = failed_jobs.sample
  random_failed_status = failed_status.sample
  random_failure = failure_causes.sample
  builds_results[random_job] = {label: random_job, value: date}

  period = date.strftime('%Y-%m-%d') + ' to ' + (date+10).strftime('%Y-%m-%d')

  #send_event('welcome', { text: period })


  failure_counts[random_failure] = { label: random_failure, value: (failure_counts[random_failure][:value] + 1) % 100 }
  #send_event('common_fault_causes', { items: failure_counts.values })


  builds_results[random_job] = { label: random_job, value: random_status + ' ' + results.sample }
  #send_event('latest_builds', { items: builds_results.values })


  latest_failed_builds[random_failed_jobs] = { label: random_failed_jobs, value: random_failed_status }
  #send_event('latest_failed_builds', { items: latest_failed_builds.values })


  top_failed_jobs[random_failed_jobs] = { label: random_failed_jobs, value: (failure_counts[random_failure][:value] + 1) % 50 }
  #send_event('top_failed_jobs', { items: top_failed_jobs.values })


end
