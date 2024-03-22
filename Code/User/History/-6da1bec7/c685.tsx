import "./App.css";

import { MainPage } from "./components/MainPage";

function App() {
  const router = createBrowserRouter([
    {
      path: "/",
      element: <App />,
      errorElement: <ErrorPage />,
      children: [
        {
          path: ":selectedVersion",
          element: <FailuresTable />,
          loader: versionLoader,
        },
      ],
    },
  ]);

  return <RouterProvider router={router} />;
}

export default App;
