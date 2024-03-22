import "./App.css";
import { MainPage, loader as resourceLoader } from "./components/MainPage";
import ErrorPage from "./errorPage.tsx";
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { FailuresTable } from "./components/FailuresTable";
import { useAppSelector } from "./app/hooks.tsx";

function App() {
  const selectedVersion = useAppSelector((state) => state.main.selectedVersion);

  const router = createBrowserRouter([
    {
      path: "/",
      element: <MainPage />,
      errorElement: <ErrorPage />,
      loader: async () => resourceLoader(selectedVersion),
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
