import "./App.css";
import { MainPage } from "./components/MainPage";
import ErrorPage from "./errorPage.tsx";
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { FailuresTable } from "./components/FailuresTable.tsx";
import { useAppSelector } from "./app/hooks.tsx";

function App() {
  const selectedVersion = useAppSelector((state) => state.main.selectedVersion);j

  const router = createBrowserRouter([
    {
      path: "/",
      element: <MainPage />,
      errorElement: <ErrorPage />,
      loader: async() => resourceLoader(selectedVersion)
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