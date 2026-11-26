trigger AccountRatingTrigger on Account (before insert, before update) {
      for (Account acc : Trigger.new) {

        if (acc.AnnualRevenue >= 1000000) {
            acc.Rating = 'Hot';
        }
        else {
            acc.Rating = 'Warm';
        }
    }
}