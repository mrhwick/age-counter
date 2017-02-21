import csv
import random

print("Writing user ids and ages to csv file named 'agefile.csv'...")

with open('agefile.csv', 'w') as csvfile:
	writer = csv.writer(csvfile, delimiter=',')
	population = range(1000000)
	random_userids = random.sample(population, 100000)
	for userid in random_userids:
		writer.writerow([userid, random.randrange(60) + 1])

print("Finished writing 'agefile.csv'")
