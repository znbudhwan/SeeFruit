import turicreate as tc
import os
#load our training data
train_data = tc.image_analysis.load_images('./Training', with_path = True, recursive = True)
test_data = tc.image_analysis.load_images('./Testing', with_path = True, recursive = True)

train_data['fruit'] = train_data['path'].apply(lambda path: os.path.basename(os.path.dirname(path)))
test_data['fruit'] = test_data['path'].apply(lambda path: os.path.basename(os.path.dirname(path)))

print(train_data.groupby("fruit", [tc.aggregate.COUNT]))

train_data.save("fruit.sframe")

#create our model

model = tc.image_classifier.create(train_data, target="fruit", max_iterations=100)
predictions = model.predict(test_data)

metrics = model.evaluate(test_data)
print(metrics["accuracy"])

print("Saving model")
model.save("fruits.model")
print("Saving CoreML model")
model.export_coreml("fruit_classifier.mlmodel")
print("Done")

