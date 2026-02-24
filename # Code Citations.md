# Code Citations

## License: unknown
https://github.com/decisiontft/decisiontft.github.io/blob/26793da929fe4ee852088c578e0df63b1e1a4ad3/stock.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/UrosSysPro/2.-godina-2023-2024/blob/4cb2390ba33320a1361d7ef5c9cf11157b0b6d14/notes/index.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: MIT
https://github.com/Wixonic/Website/blob/6a673fc2c67b7ca871ba8adf93f053b16a13b7cc/public/firebase.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/decisiontft/decisiontft.github.io/blob/26793da929fe4ee852088c578e0df63b1e1a4ad3/stock.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/UrosSysPro/2.-godina-2023-2024/blob/4cb2390ba33320a1361d7ef5c9cf11157b0b6d14/notes/index.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: MIT
https://github.com/Wixonic/Website/blob/6a673fc2c67b7ca871ba8adf93f053b16a13b7cc/public/firebase.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/GoveRaven/kanban-board/blob/fbd8fd5046baf5381544b7f3e0446a8ca3ce7f1d/scripts/firebaseConfig.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
    authDomain: "greengrid-hill.firebaseapp.com
```


## License: unknown
https://github.com/decisiontft/decisiontft.github.io/blob/26793da929fe4ee852088c578e0df63b1e1a4ad3/stock.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/UrosSysPro/2.-godina-2023-2024/blob/4cb2390ba33320a1361d7ef5c9cf11157b0b6d14/notes/index.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: MIT
https://github.com/Wixonic/Website/blob/6a673fc2c67b7ca871ba8adf93f053b16a13b7cc/public/firebase.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/GoveRaven/kanban-board/blob/fbd8fd5046baf5381544b7f3e0446a8ca3ce7f1d/scripts/firebaseConfig.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
    authDomain: "greengrid-hill.firebaseapp.com
```


## License: unknown
https://github.com/decisiontft/decisiontft.github.io/blob/26793da929fe4ee852088c578e0df63b1e1a4ad3/stock.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/UrosSysPro/2.-godina-2023-2024/blob/4cb2390ba33320a1361d7ef5c9cf11157b0b6d14/notes/index.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: MIT
https://github.com/Wixonic/Website/blob/6a673fc2c67b7ca871ba8adf93f053b16a13b7cc/public/firebase.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/GoveRaven/kanban-board/blob/fbd8fd5046baf5381544b7f3e0446a8ca3ce7f1d/scripts/firebaseConfig.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
    authDomain: "greengrid-hill.firebaseapp.com
```


## License: unknown
https://github.com/decisiontft/decisiontft.github.io/blob/26793da929fe4ee852088c578e0df63b1e1a4ad3/stock.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/UrosSysPro/2.-godina-2023-2024/blob/4cb2390ba33320a1361d7ef5c9cf11157b0b6d14/notes/index.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: MIT
https://github.com/Wixonic/Website/blob/6a673fc2c67b7ca871ba8adf93f053b16a13b7cc/public/firebase.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/GoveRaven/kanban-board/blob/fbd8fd5046baf5381544b7f3e0446a8ca3ce7f1d/scripts/firebaseConfig.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
    authDomain: "greengrid-hill.firebaseapp.com
```


## License: unknown
https://github.com/decisiontft/decisiontft.github.io/blob/26793da929fe4ee852088c578e0df63b1e1a4ad3/stock.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/UrosSysPro/2.-godina-2023-2024/blob/4cb2390ba33320a1361d7ef5c9cf11157b0b6d14/notes/index.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: MIT
https://github.com/Wixonic/Website/blob/6a673fc2c67b7ca871ba8adf93f053b16a13b7cc/public/firebase.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/GoveRaven/kanban-board/blob/fbd8fd5046baf5381544b7f3e0446a8ca3ce7f1d/scripts/firebaseConfig.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
    authDomain: "greengrid-hill.firebaseapp.com
```


## License: unknown
https://github.com/decisiontft/decisiontft.github.io/blob/26793da929fe4ee852088c578e0df63b1e1a4ad3/stock.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/UrosSysPro/2.-godina-2023-2024/blob/4cb2390ba33320a1361d7ef5c9cf11157b0b6d14/notes/index.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: MIT
https://github.com/Wixonic/Website/blob/6a673fc2c67b7ca871ba8adf93f053b16a13b7cc/public/firebase.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/GoveRaven/kanban-board/blob/fbd8fd5046baf5381544b7f3e0446a8ca3ce7f1d/scripts/firebaseConfig.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
    authDomain: "greengrid-hill.firebaseapp.com
```


## License: unknown
https://github.com/decisiontft/decisiontft.github.io/blob/26793da929fe4ee852088c578e0df63b1e1a4ad3/stock.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/UrosSysPro/2.-godina-2023-2024/blob/4cb2390ba33320a1361d7ef5c9cf11157b0b6d14/notes/index.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: MIT
https://github.com/Wixonic/Website/blob/6a673fc2c67b7ca871ba8adf93f053b16a13b7cc/public/firebase.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/GoveRaven/kanban-board/blob/fbd8fd5046baf5381544b7f3e0446a8ca3ce7f1d/scripts/firebaseConfig.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
    authDomain: "greengrid-hill.firebaseapp.com
```


## License: MIT
https://github.com/Wixonic/Website/blob/6a673fc2c67b7ca871ba8adf93f053b16a13b7cc/public/firebase.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/decisiontft/decisiontft.github.io/blob/26793da929fe4ee852088c578e0df63b1e1a4ad3/stock.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/UrosSysPro/2.-godina-2023-2024/blob/4cb2390ba33320a1361d7ef5c9cf11157b0b6d14/notes/index.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
```


## License: unknown
https://github.com/GoveRaven/kanban-board/blob/fbd8fd5046baf5381544b7f3e0446a8ca3ce7f1d/scripts/firebaseConfig.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
    authDomain: "greengrid-hill.firebaseapp.com
```


## License: MIT
https://github.com/Wixonic/Website/blob/6a673fc2c67b7ca871ba8adf93f053b16a13b7cc/public/firebase.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
    authDomain: "greengrid-hill.firebaseapp.com
```


## License: unknown
https://github.com/decisiontft/decisiontft.github.io/blob/26793da929fe4ee852088c578e0df63b1e1a4ad3/stock.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
    authDomain: "greengrid-hill.firebaseapp.com
```


## License: unknown
https://github.com/UrosSysPro/2.-godina-2023-2024/blob/4cb2390ba33320a1361d7ef5c9cf11157b0b6d14/notes/index.html

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
    authDomain: "greengrid-hill.firebaseapp.com
```


## License: unknown
https://github.com/GoveRaven/kanban-board/blob/fbd8fd5046baf5381544b7f3e0446a8ca3ce7f1d/scripts/firebaseConfig.js

```
I can see the problem! Looking at your Firebase Console screenshot, the API key shown is:

```
apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4"
```

But in the Network request, it's using:

```
AIzaSyD2tjYP4kgFh_ClomJHLFBn_4Y0N_eT4
```

**These are DIFFERENT API keys!** That's why it says "API key not valid" - you're using the wrong key in your code.

## 🔧 Fix: Update Your Firebase Configuration

### Step 1: Copy the CORRECT API Key

From the Firebase Console screenshot, copy this exact configuration:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
  authDomain: "greengrid-hill.firebaseapp.com",
  databaseURL: "https://greengrid-hill-default-rtdb.firebaseio.com",
  projectId: "greengrid-hill",
  storageBucket: "greengrid-hill.firebasestorage.app",
  messagingSenderId: "100159620207",
  appId: "1:100159620207:web:50cf0ed26bc98a14c48d6a",
  measurementId: "G-4XXJJQXCGM"
};
```

### Step 2: Update web/index.html

Open `web/index.html` and find the Firebase configuration section (around lines 30-50). Replace it with:

````html
<!-- filepath: d:\MAD PROJECT\greengrid hill\greengridhill\web\index.html -->
<!-- ...existing code... -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getAuth } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyD2EriYP4k4FL_ClomJHLFBn_4Y9M_eT4",
    authDomain: "greengrid-hill.firebaseapp.com
```

