# RegionDeviceCount API User Story

## User Story 1 - Emergency Rescue

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an emergency rescue worker, I hope to be able to obtain the number of users in an area where a special emergency activities could be needed through an API, so as to quickly understand the situation, plan and guide the rescue work.  |
| ***Background*** | In the event of a disaster or emergency, understanding the population within the affected area is crucial for timely scheduling of rescue operations. Therefore, we need an interface to obtain this information. |
| ***User requirements*** |1.I hope to obtain the number of connected devices on people in the area by providing coordinates or boundary information.<br>2.I need the information returned by the API to include the total number and distribution of the devices in that area.<br>3.I need the response time of the API is very short, so that information can be quickly obtained in emergency situations.<br>4. I need a reliable factual information only, if/how to estimate and handle population which does not have connected devices on them is my task (depends on the area and situation).|
| ***Acceptance criteria*** | 1.I can provide the coordinates or boundary information of the area by calling the API, and successfully obtain the number of connected devices on people in that area.<br>2.The information returned by the API includes the total number and distribution of the devices (using a grid).<br>3.The response time of the API should be within a few seconds to meet the needs of emergency rescue. |
