UIALogger.logMessage("Start");

target = UIATarget.localTarget();
app = target.frontMostApp();

target.delay(5);

UIALogger.logMessage("End");

