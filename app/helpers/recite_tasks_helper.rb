module ReciteTasksHelper

	def get_score_color(score)

		case score
		when 70..100
			return "#f1c40f"
		when 40..70
			return "#e67e22"
		when 0..40
			return "#e74c3c"
		end
		
	end


	def get_day_count(time)
		day = ((time - Time.now)/86400).to_i
		
		day += 1 if (time - Time.now) > ( Date.today.end_of_day - Time.now)

	end

end
