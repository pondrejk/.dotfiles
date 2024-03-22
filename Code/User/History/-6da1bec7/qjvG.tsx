import "./App.css";
import { MainPage, loader as resourceLoader } from "./components/MainPage";
import ErrorPage from "./errorPage.tsx";
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { FailuresTable } from "./components/failurestable.tsx";
import { useAppSelector, useappselector } from "./app/hooks.tsx";

function App() {
  const selectedVersion = useAppSelector((state) => state.main.selectedVersion);

  const router = createBrowserRouter([
    {
      path: "/",
      element: <MainPage />,
      errorElement: <ErrorPage />,
      children: [
        {
          path: ":selectedVersion",
          element: <FailuresTable />,
          loader: async () => resourceLoader(selectedVersion),
        },
      ],
    },
  ]);

  return <RouterProvider router={router} />;
}

export default App;
