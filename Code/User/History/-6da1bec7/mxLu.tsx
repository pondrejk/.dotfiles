import "./App.css";

import { MainPage } from "./components/MainPage";
import ErrorPage from "./errorPage.tsx";

import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { FailuresTable } from "./components/FailuresTable.tsx";

function App() {
  const router = createBrowserRouter([
    {
      path: "/",
      element: <MainPage />,
      errorElement: <ErrorPage />,
      children: [
        {
          path: ":selectedVersion",
          element: <FailuresTable />,
        },
      ],
    },
  ]);

  return <RouterProvider router={router} />;
}

export default App;
