import React from "react";
import {
  Masthead,
  MastheadBrand,
  MastheadMain,
  MastheadToggle,
  Nav,
  NavItem,
  NavList,
  Page,
  PageSection,
  PageSectionVariants,
  PageSidebar,
  PageSidebarBody,
  PageToggleButton,
  SkipToContent,
  Text,
  TextContent,
  Tabs,
  Tab,
  TabTitleText,
  Spinner,
} from "@patternfly/react-core";
import BarsIcon from "@patternfly/react-icons/dist/esm/icons/bars-icon";
import { FailuresTable } from "../components/FailuresTable";
import { useAppDispatch, useAppSelector } from "../app/hooks";
import { selectVersion, selectSnap } from "../MainSlice";
import {
  clusterApi,
  useGetSnapDataQuery,
  useGetVersionsQuery,
} from "../services/api";
import { useGetSnapsPerVersionQuery } from "../services/api";
import { useLazyGetSnapDataQuery } from "../services/api";
import { useEffect } from "react";

import data2 from "../data/launch_743.json";

export const MainPage: React.FunctionComponent = () => {
  const dispatch = useAppDispatch();
  const selectedVersion = useAppSelector((state) => state.main.selectedVersion);
  const selectedSnap = useAppSelector((state) => state.main.selectedSnap);
  const { data: versionData } = useGetVersionsQuery();
  const { data: snapsData } = useGetSnapsPerVersionQuery(selectedVersion);
  /*
  const [trigger, { data, error, isLoading }] = useLazyGetSnapDataQuery(
    selectedVersion,
    selectedSnap
  );
  */

  //const { data, isSuccess, isLoading, isError, error } = useGetSnapDataQuery();

  //useEffect(() => {}, [selectedVersion, selectedSnap]);

  function setVersion(v: string) {
    dispatch(selectVersion(v));
  }

  function setSnap(v: string) {
    dispatch(selectSnap(v));
  }

  function getData(selectedVersion: string, selectedSnap: string) {
    const { data, error, isLoading } =
      clusterApi.endpoints.getSnapData.useQuery(selectedVersion, selectedSnap);

    console.log(typeof selectedSnap);
    if (selectedVersion && selectedSnap) {
      /*
      if (error) {
        return "error";
      }
      if (isLoading) {
        return <Spinner aria-label="loading" />;
      }
      */
      return <FailuresTable data={data2} />;
    } else {
      return <Spinner aria-label="loading" />;
    }
  }

  function buildSnapTabs() {
    if (selectedSnap === "" || !snapsData.versions.includes(selectedSnap)) {
      setSnap(snapsData.versions[0]);
    }
    const tablist = snapsData.versions.map((version: string) => {
      return (
        <Tab
          eventKey={version}
          key={version}
          title={<TabTitleText>Snap {version}</TabTitleText>}
        ></Tab>
      );
    });
    return tablist;
  }

  const masthead = (
    <Masthead>
      <MastheadToggle>
        <PageToggleButton variant="plain" aria-label="Global navigation">
          <BarsIcon />
        </PageToggleButton>
      </MastheadToggle>
      <MastheadMain>
        <MastheadBrand>Unique Errors Dashboard</MastheadBrand>
      </MastheadMain>
    </Masthead>
  );

  const pageNav = (
    <Nav>
      <NavList>
        {versionData &&
          versionData.versions.map((ver: string, i) => {
            return (
              <NavItem
                itemId={i}
                key={i}
                isActive={ver === selectedVersion}
                onClick={() => setVersion(ver)}
              >
                {ver}
              </NavItem>
            );
          })}
      </NavList>
    </Nav>
  );

  const sidebar = (
    <PageSidebar>
      <PageSidebarBody>{pageNav}</PageSidebarBody>
    </PageSidebar>
  );

  const mainContainerId = "main-content";

  const pageSkipToContent = (
    <SkipToContent href={`#${mainContainerId}`}>Skip to content</SkipToContent>
  );

  const handleTabClick = (
    event: React.MouseEvent<any> | React.KeyboardEvent | MouseEvent,
    tabIndex: string | number
  ) => {
    setSnap(tabIndex);
  };

  return (
    <Page
      header={masthead}
      sidebar={sidebar}
      isManagedSidebar
      skipToContent={pageSkipToContent}
      mainContainerId={mainContainerId}
      isBreadcrumbWidthLimited
      isBreadcrumbGrouped
      additionalGroupedContent={
        <PageSection variant={PageSectionVariants.light} isWidthLimited>
          <TextContent>
            <Text component="h1">
              Satellite <b>{selectedVersion}</b> error clusters
            </Text>
          </TextContent>
          <Tabs
            activeKey={selectedSnap}
            aria-label="Tabs in the default example"
            role="region"
            onSelect={handleTabClick}
          >
            {snapsData && buildSnapTabs()}
          </Tabs>
        </PageSection>
      }
      groupProps={{
        stickyOnBreakpoint: { default: "top" },
      }}
    >
      <PageSection>{getData(selectedVersion, selectedSnap)}</PageSection>
    </Page>
  );
};
